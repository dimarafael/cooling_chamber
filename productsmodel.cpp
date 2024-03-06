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
