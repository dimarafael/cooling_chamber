#include "processmodel.h"

ProcessModel::ProcessModel(QObject *parent)
    :QAbstractListModel{parent}
{
    for(int i =0; i < 12; i++){
        m_processList.append(ProcessItem());
    }

    // m_processList[1].setState(1);
    // m_processList[2].setState(2);
    // m_processList[3].setCoolMode(true);
    // m_processList[0].setT4(-88.8);
    // m_processList[0].setT3(-77.7);
    // m_processList[0].setT2(-12.3);
    // m_processList[0].setT1(-45.6);
    // m_processList[0].setState(2);
    // m_processList[0].setSetpoint(-18.8);
    // m_processList[1].setSetpoint(-5);
    // m_processList[0].setProductName("Product name 1");
    // m_processList[0].setTarget(1);
    // m_processList[1].setTarget(2);
    // m_processList[2].setTarget(3);
    // m_processList[1].setCoolMode(true);
    // m_processList[2].setOffline(true);
    // m_processList[11].setDischarged(true);
}

int ProcessModel::rowCount(const QModelIndex &parent) const
{
    return m_processList.count();
}

QVariant ProcessModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() <m_processList.count()){
        ProcessItem processItem = m_processList[index.row()];
        switch ((Role)role) {
        case Temperature1Role:
            return processItem.t1();
        case Temperature2Role:
            return processItem.t2();
        case Temperature3Role:
            return processItem.t3();
        case Temperature4Role:
            return processItem.t4();
        case SetpointRole:
            return processItem.setpoint();
        case CoolModeRole:
            return processItem.coolMode();
        case StageRole:
            return processItem.state();
        case TargetRole:
            return processItem.target();
        case ProductNameRole:
            return processItem.productName();
        case DischargedRole:
            return processItem.discharged();
        case OfflineRole:
            return processItem.offline();
        default:
            return {};
        }
    }
    return {};
}

QHash<int, QByteArray> ProcessModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[Temperature1Role] = "temperature1";
    names[Temperature2Role] = "temperature2";
    names[Temperature3Role] = "temperature3";
    names[Temperature4Role] = "temperature4";
    names[SetpointRole] = "setpoint";
    names[CoolModeRole] = "coolMode";
    names[StageRole] = "stage";
    names[TargetRole] = "target";
    names[ProductNameRole] = "productName";
    names[DischargedRole] = "discharged";
    names[OfflineRole] = "offline";
    return names;
}

void ProcessModel::dataReady(QVector<ProbeData> data)
{
    qInfo() << "Process model data ready";
    beginResetModel();
    for(int i = 0; i < 12; i++){
        m_processList[i].setT1(data[i].t1());
        m_processList[i].setT2(data[i].t2());
        m_processList[i].setT3(data[i].t3());
        m_processList[i].setT4(data[i].t4());
        m_processList[i].setOffline(!data[i].online());
        m_processList[i].setDischarged(false);// !!!!!!!!!! Write logic for discharged
    }
    calculateProcess();
    endResetModel();
}

void ProcessModel::updateConnectedState(bool connected)
{
    setGatewayOnline(connected);
}

void ProcessModel::calculateTargets()
{
    m_target1 = 0;
    m_target2 = 0;
    m_target3 = 0;

    for(int i = 0; i < m_processList.count(); i++){
        if (m_processList[i].state() > 0){
            if(m_processList[i].target() == 1) m_target1++;
            if(m_processList[i].target() == 2) m_target2++;
            if(m_processList[i].target() == 3) m_target3++;
        }
    }
    emit target1Changed();
    emit target2Changed();
    emit target3Changed();
}

void ProcessModel::calculateProcess()
{
    for(int i = 0; i < m_processList.count(); i++){
        if (m_processList[i].state() == 1 && !m_processList[i].offline()){ // 0 - empty, 1 - cooling, 2 - ready
            if(m_processList[i].coolMode()){ // false - only one sensor, true - all sensers
                if(m_processList[i].t1() <= m_processList[i].setpoint() &&
                    m_processList[i].t2() <= m_processList[i].setpoint() &&
                    m_processList[i].t3() <= m_processList[i].setpoint() &&
                    m_processList[i].t4() <= m_processList[i].setpoint()){
                    m_processList[i].setState(2);
                    emit lampStart();
                }
            } else{
                if(m_processList[i].t1() <= m_processList[i].setpoint() ||
                    m_processList[i].t2() <= m_processList[i].setpoint() ||
                    m_processList[i].t3() <= m_processList[i].setpoint() ||
                    m_processList[i].t4() <= m_processList[i].setpoint()){
                    m_processList[i].setState(2);
                    emit lampStart();
                }
            }
        }
    }

    bool needLamp = false;
    for(int i = 0; i < m_processList.count(); i++){
        if(m_processList[i].state() == 2) needLamp = true;
    }
    if (!needLamp) emit lampStop();
}

bool ProcessModel::gatewayOnline() const
{
    return m_gatewayOnline;
}

void ProcessModel::setGatewayOnline(bool newGatewayOnline)
{
    if (m_gatewayOnline == newGatewayOnline)
        return;
    m_gatewayOnline = newGatewayOnline;
    emit gatewayOnlineChanged();
}

void ProcessModel::stopProcess(int index)
{
    beginResetModel();
    m_processList[index].setState(0);
    endResetModel();
    calculateTargets();
}

void ProcessModel::startProcess(int index, QString productName, float setpoint, bool coolMode, int target)
{
    beginResetModel();
    m_processList[index].setProductName(productName);
    m_processList[index].setSetpoint(setpoint);
    m_processList[index].setCoolMode(coolMode);
    m_processList[index].setState(1);
    m_processList[index].setTarget(target);
    endResetModel();
    calculateTargets();
}

int ProcessModel::target1() const
{
    return m_target1;
}

void ProcessModel::setTarget1(int newTarget1)
{
    if (m_target1 == newTarget1)
        return;
    m_target1 = newTarget1;
    emit target1Changed();
}

int ProcessModel::target2() const
{
    return m_target2;
}

void ProcessModel::setTarget2(int newTarget2)
{
    if (m_target2 == newTarget2)
        return;
    m_target2 = newTarget2;
    emit target2Changed();
}

int ProcessModel::target3() const
{
    return m_target3;
}

void ProcessModel::setTarget3(int newTarget3)
{
    if (m_target3 == newTarget3)
        return;
    m_target3 = newTarget3;
    emit target3Changed();
}
