#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QThread>
#include "processmodel.h"
#include "readprobes.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ProcessModel *processModel = new ProcessModel(&app);
    qmlRegisterSingletonInstance("com.kometa.ProcessModel", 1, 1, "ProcessModel", processModel);


    ReadProbes *readProbes = new ReadProbes();
    QThread *threadReadingProbes = new QThread();
    QObject::connect(threadReadingProbes, &QThread::started, readProbes, &ReadProbes::run);

    QObject::connect(readProbes, &ReadProbes::dataReady, processModel, &ProcessModel::dataReady);

    readProbes->moveToThread(threadReadingProbes);
    threadReadingProbes->start();

    const QUrl url(u"qrc:/cooling_chamber/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
