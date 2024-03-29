#ifndef PROCESSMODEL_H
#define PROCESSMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include "processitem.h"
#include "probedata.h"

class ProcessModel : public QAbstractListModel
{
    Q_OBJECT
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

public slots:
    void dataReady(QVector<ProbeData> data);

private:
    QList<ProcessItem> m_processList;
};

#endif // PROCESSMODEL_H
