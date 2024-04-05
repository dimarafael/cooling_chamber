#ifndef LAMP_H
#define LAMP_H

#include <QObject>
#include <QFile>
#include <QTimer>

class Lamp : public QObject
{
    Q_OBJECT
public:
    explicit Lamp(QObject *parent = nullptr);

signals:

public slots:
    void start();
    void stop();

private slots:
    void timeout();

private:
    QTimer *m_timer;
    bool m_lampState = false;
    QFile file;
    void setOutMode();
    void onLamp();
    void offLamp();
};

#endif // LAMP_H
