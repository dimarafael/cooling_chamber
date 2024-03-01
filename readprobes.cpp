#include "readprobes.h"


ReadProbes::ReadProbes()
{

}

ReadProbes::~ReadProbes()
{

}

void ReadProbes::run()
{
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
#endif


}
