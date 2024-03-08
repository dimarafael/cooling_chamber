#ifndef PRODUCTSMODEL_H
#define PRODUCTSMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include "product.h"

class ProductsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Role{
        ProductNameRole = Qt::UserRole + 1,
        SetpointRole = Qt::UserRole + 2,
        CoolModeRole = Qt::UserRole + 3
    };

    explicit ProductsModel(QObject *parent = nullptr);

    // QAbstractItemModel interface
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void append(QString name, float setpoint, bool mode);
    Q_INVOKABLE void remove(int row);
    Q_INVOKABLE void set(int row, QString name, float setpoint, bool mode);

private:
    QList<Product> m_productList;
};

#endif // PRODUCTSMODEL_H
