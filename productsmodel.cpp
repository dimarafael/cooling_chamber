#include "productsmodel.h"

ProductsModel::ProductsModel(QObject *parent)
    : QAbstractListModel{parent}
{}

int ProductsModel::rowCount(const QModelIndex &parent) const
{
    return m_productList.count();
}

QVariant ProductsModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() <m_productList.count()){
        Product product = m_productList[index.row()];
        switch ((Role)role) {
        case ProductNameRole:
            return product.name();
        case SetpointRole:
            return product.setpoint();
        case CoolModeRole:
            return product.coolMode();
        default:
            return {};
        }
    }
    return {};
}

QHash<int, QByteArray> ProductsModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[ProductNameRole] = "productName";
    names[SetpointRole] = "setpoint";
    names[CoolModeRole] = "coolMode";
    return names;
}

void ProductsModel::append(QString name, float setpoint, bool mode)
{
    Product product;
    product.setName(name);
    product.setSetpoint(setpoint);
    product.setCoolMode(mode);

    beginInsertRows(QModelIndex(),m_productList.size(),m_productList.size());
    m_productList.append(product);
    endInsertRows();
}

void ProductsModel::remove(int row)
{
    if(row < 0 || row >= m_productList.size())
        return;

    beginRemoveRows(QModelIndex(),row, row);
    m_productList.removeAt(row);
    endRemoveRows();
}

void ProductsModel::set(int row, QString name, float setpoint, bool mode)
{
    if(row < 0 || row >= m_productList.size())
        return;

    Product product;
    product.setName(name);
    product.setSetpoint(setpoint);
    product.setCoolMode(mode);

    m_productList.replace(row, product);
    emit dataChanged(index(row,0), index(row,0));
}

