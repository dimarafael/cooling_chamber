#ifndef LAMP_H
#define LAMP_H

#include <QObject>
#include <QFile>

class Lamp : public QObject
{
    Q_OBJECT
public:
    explicit Lamp(QObject *parent = nullptr);

signals:

private:
};

#endif // LAMP_H
