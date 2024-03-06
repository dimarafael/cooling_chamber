
#include <QTest>

class BasicsTest : public QObject
{
    Q_OBJECT

private slots:
    void toString();
};

void BasicsTest::toString()
{
    float f = 2;
    QCOMPARE(f,2);
}

QTEST_MAIN(BasicsTest)

#include "tst_basics.moc"
