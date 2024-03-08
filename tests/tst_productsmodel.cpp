#include <QTest>
#include "../productsmodel.h"
#include "../product.h"

class ProductsModelTest : public QObject
{
    Q_OBJECT
private slots:
    void testRowCountZero();
};



void ProductsModelTest::testRowCountZero()
{
    ProductsModel pm;
    QCOMPARE(pm.rowCount(QModelIndex()), 0);
}

QTEST_MAIN(ProductsModelTest)

#include "tst_productsmodel.moc"
