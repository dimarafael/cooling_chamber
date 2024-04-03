#include "readprobes.h"


ReadProbes::ReadProbes()
{
    mc = new QModbusTcpClient(this);
    mc->setConnectionParameter(QModbusDevice::NetworkAddressParameter, "10.0.14.88");
    mc->setConnectionParameter(QModbusDevice::NetworkPortParameter, 1502);
    connect(mc, &QModbusClient::stateChanged, this, &ReadProbes::processStateChanged);
}

ReadProbes::~ReadProbes()
{

}

void ReadProbes::run()
{
#ifndef SIMULATION
    mc->connectDevice();
#endif
    m_currentDevice = 0;
    m_probes = new QVector<ProbeData>(N_PROBES);
    m_timer = new QTimer(this);
    m_timer->setInterval(5000);
    connect(m_timer, &QTimer::timeout, this, &ReadProbes::readData);
    m_timer->start();
}

void ReadProbes::readData()
{

#ifdef SIMULATION
    qInfo() << "Simulation probes";
    for(int i = 0; i < N_PROBES; i++){
        ProbeData tmp_probeData;
        tmp_probeData.setT1(static_cast<float>(QRandomGenerator::global()->bounded(180,230))/10);
        tmp_probeData.setT2(static_cast<float>(QRandomGenerator::global()->bounded(180,230))/10);
        tmp_probeData.setT3(static_cast<float>(QRandomGenerator::global()->bounded(180,230))/10);
        tmp_probeData.setT4(static_cast<float>(QRandomGenerator::global()->bounded(180,230))/10);
        tmp_probeData.setOnline(true);
        m_probes->replace(i, tmp_probeData);
    }
    emit dataReady(*m_probes);
#endif // SIMULATION

#ifndef SIMULATION
    if(mc->state() == QModbusDevice::ConnectedState){

        if(du != nullptr) delete du;
        du = new QModbusDataUnit(QModbusDataUnit::HoldingRegisters, (12188 + 150 * (m_currentDevice + 1)) ,QVector<quint16>(1));
        if(auto *reply = mc->sendReadRequest(*du,1)){
            if(reply->isFinished()){
                delete reply;
                incrementCurrentDevice(false);
            } else{
                connect(reply, &QModbusReply::finished, this, &ReadProbes::processOnlineStatus);
            }
        } else {
            qDebug() << "Reply error for sensor" << m_currentDevice << " : " << mc->errorString();
            incrementCurrentDevice(false);
        }

    } else if (mc->state() == QModbusDevice::UnconnectedState){
        mc->connectDevice();
    }

#endif // not SIMULATION

}

//ModbusClient state changed
void ReadProbes::processStateChanged(QModbusDevice::State state)
{
    qDebug() << "Modbus connection: " << mc->state();
    if(mc->state() == QModbusDevice::ConnectedState){
        emit updateConnectedState(true);
    } else{
        emit updateConnectedState(false);
    }
}

void ReadProbes::processOnlineStatus()
{
    auto reply = qobject_cast<QModbusReply *>(sender());
    if (!reply || reply->error()){
        incrementCurrentDevice(false);
        return;
    }

    if(!reply->error()){
        if((reply->result().values()[0] & (1 << 9)) == 512){ // 512 - probe online
            // qDebug() << "Sensor " << QString::number(m_currentDevice) << " online";

            // probe connected, try to read data about temperatures
            if(mc->state() == QModbusDevice::ConnectedState){

                if(du != nullptr) delete du;
                du = new QModbusDataUnit(QModbusDataUnit::HoldingRegisters, (12201 + 150 * (m_currentDevice + 1)) ,QVector<quint16>(7));
                if(auto *reply = mc->sendReadRequest(*du,1)){
                    if(reply->isFinished()){
                        delete reply;
                        incrementCurrentDevice(false);
                    } else{
                        connect(reply, &QModbusReply::finished, this, &ReadProbes::processTemperatures);
                    }
                } else {
                    qDebug() << "Reply error for sensor" << m_currentDevice << " : " << mc->errorString();
                    incrementCurrentDevice(false);
                }
            } else{
                incrementCurrentDevice(false);
                if (mc->state() == QModbusDevice::UnconnectedState) mc->connectDevice();
            }

        } else{
            incrementCurrentDevice(false);
        }
    }
    reply->deleteLater();
}

void ReadProbes::processTemperatures()
{
    auto reply = qobject_cast<QModbusReply *>(sender());
    if (!reply || reply->error()){
        incrementCurrentDevice(false);
        return;
    }
    if(!reply->error()){
        ProbeData tmp_probeData;
        tmp_probeData.setOnline(true);
        tmp_probeData.setT1(quit16ToFloat(reply->result().values()[2])/10);
        tmp_probeData.setT2(quit16ToFloat(reply->result().values()[4])/10);
        tmp_probeData.setT3(quit16ToFloat(reply->result().values()[1])/10);
        tmp_probeData.setT4(quit16ToFloat(reply->result().values()[0])/10);
        tmp_probeData.setBattery(reply->result().values()[6]);
        m_probes->replace(m_currentDevice, tmp_probeData);
        incrementCurrentDevice(true);
    }
    reply->deleteLater();
}

void ReadProbes::incrementCurrentDevice(bool isOnline)
{
    if(!isOnline){
        ProbeData tmp_probeData;
        tmp_probeData.setOnline(false);
        m_probes->replace(m_currentDevice, tmp_probeData);
    }

    if(m_currentDevice < N_PROBES - 1){
        m_currentDevice++;
        readData();
    }
    else{
        m_currentDevice = 0;
        emit dataReady(*m_probes);
    }
}

float ReadProbes::quit16ToFloat(quint16 data)
{
    int intData;
    if((data & (1 << 15)) == 0){ // positive
        intData = data;
    } else{ // negative
        quint16 tmp = ~data;
        intData = -1 * static_cast<int>(tmp);
    }

    return static_cast<float>(intData);
}
