#include <QTest>
#include "../product.h"

class ProductTest : public QObject
{
    Q_OBJECT

private slots:
    void testName();
    void testSetpoint();
    void testMode();
};

void ProductTest::testName()
{
    Product p;
    QString name = "ABC1&%&*&^ ";
    p.setName(name);
    QCOMPARE(p.name(), name);
}

void ProductTest::testSetpoint()
{
    Product p;
    float sp = -123.4567;
    p.setSetpoint(sp);
    QCOMPARE(p.setpoint(), sp);
}

void ProductTest::testMode()
{
    Product p;
    bool mode = true;
    p.setCoolMode(mode);
    QCOMPARE(p.coolMode(), mode);
}

QTEST_MAIN(ProductTest)

#include "tst_product.moc"
