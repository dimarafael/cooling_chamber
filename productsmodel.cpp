#include "productsmodel.h"

ProductsModel::ProductsModel(QObject *parent)
    : QAbstractListModel{parent}
{
    // for(int i=0; i<25; i++){
    //     Product prd;
    //     prd.setName("Product" + QString::number(i));
    //     prd.setSetpoint(-1.7 - i);
    //     m_productList.append(prd);
    // }
    readFromSettings();
}

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
    writeToSettings();
}

void ProductsModel::remove(int row)
{
    if(row < 0 || row >= m_productList.size())
        return;

    beginRemoveRows(QModelIndex(),row, row);
    m_productList.removeAt(row);
    endRemoveRows();
    writeToSettings();
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
    writeToSettings();
}

void ProductsModel::readFromSettings()
{
    int size = m_settings.beginReadArray("products");
    for (int i = 0; i < size; ++i) {
        m_settings.setArrayIndex(i);
        Product product;
        product.setName(m_settings.value("name").toString());
        product.setSetpoint(m_settings.value("setpoint").toFloat());
        product.setCoolMode(m_settings.value("mode").toBool());
        m_productList.append(product);
    }
    m_settings.endArray();
}

void ProductsModel::writeToSettings()
{
    m_settings.beginWriteArray("products");
    for(qsizetype i = 0; i < m_productList.size(); ++i){
        m_settings.setArrayIndex(i);
        m_settings.setValue("name", m_productList.at(i).name());
        m_settings.setValue("setpoint", m_productList.at(i).setpoint());
        m_settings.setValue("mode", m_productList.at(i).coolMode());
    }
    m_settings.endArray();
}


