#ifndef LAMP_H
#define LAMP_H

#include <QObject>
#include <QProcess>

class Lamp : public QObject
{
    Q_OBJECT
public:
    explicit Lamp(QObject *parent = nullptr);

signals:

private:
    QProcess m_process;
};

#endif // LAMP_H
