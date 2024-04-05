#ifndef PROCESSMODEL_H
#define PROCESSMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include "processitem.h"
#include "probedata.h"
#include "lamp.h"

class ProcessModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool gatewayOnline READ gatewayOnline WRITE setGatewayOnline NOTIFY gatewayOnlineChanged FINAL)
    Q_PROPERTY(int target1 READ target1 WRITE setTarget1 NOTIFY target1Changed FINAL)
    Q_PROPERTY(int target2 READ target2 WRITE setTarget2 NOTIFY target2Changed FINAL)
    Q_PROPERTY(int target3 READ target3 WRITE setTarget3 NOTIFY target3Changed FINAL)
public:
    enum Role{
        Temperature1Role = Qt::UserRole + 1,
        Temperature2Role = Qt::UserRole + 2,
        Temperature3Role = Qt::UserRole + 3,
        Temperature4Role = Qt::UserRole + 4,
        SetpointRole = Qt::UserRole + 5,
        CoolModeRole = Qt::UserRole + 6,
        StageRole = Qt::UserRole + 7,
        TargetRole = Qt::UserRole + 8,
        ProductNameRole = Qt::UserRole + 9,
        DischargedRole = Qt::UserRole + 10,
        OfflineRole = Qt::UserRole + 11
    };
    explicit ProcessModel(QObject *parent = nullptr);

public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    bool gatewayOnline() const;
    void setGatewayOnline(bool newGatewayOnline);

    Q_INVOKABLE void stopProcess(int index);
    Q_INVOKABLE void startProcess(int index, QString productName, float setpoint, bool coolMode, int target);

    int target1() const;
    void setTarget1(int newTarget1);

    int target2() const;
    void setTarget2(int newTarget2);

    int target3() const;
    void setTarget3(int newTarget3);

public slots:
    void dataReady(QVector<ProbeData> data);
    void updateConnectedState(bool connected);

signals:
    void gatewayOnlineChanged();

    void target1Changed();

    void target2Changed();

    void target3Changed();

private:
    QList<ProcessItem> m_processList;
    bool m_gatewayOnline = false;
    int m_target1 = 0;
    int m_target2 = 0;
    int m_target3 = 0;

    void calculateTargets();
    void calculateProcess();

    Lamp *m_lamp;
};

#endif // PROCESSMODEL_H
