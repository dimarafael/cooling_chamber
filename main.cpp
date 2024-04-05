#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QThread>
#include "processmodel.h"
#include "readprobes.h"
#include "productsmodel.h"
#include "lamp.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setOrganizationName("Kometa");
    QCoreApplication::setOrganizationDomain("kometa.hu");
    QCoreApplication::setApplicationName("Cooling Chamber");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ProcessModel *processModel = new ProcessModel(&app);
    qmlRegisterSingletonInstance("com.kometa.ProcessModel", 1, 1, "ProcessModel", processModel);

    Lamp *lamp = new Lamp(&app);
    QObject::connect(processModel, &ProcessModel::lampStart, lamp, &Lamp::start);
    QObject::connect(processModel, &ProcessModel::lampStop, lamp, &Lamp::stop);

    ProductsModel *productsModel = new ProductsModel(&app);
    qmlRegisterSingletonInstance("com.kometa.ProductsModel", 1, 1, "ProductsModel", productsModel);

    ReadProbes *readProbes = new ReadProbes();
    QThread *threadReadingProbes = new QThread();
    QObject::connect(threadReadingProbes, &QThread::started, readProbes, &ReadProbes::run);

    QObject::connect(readProbes, &ReadProbes::dataReady, processModel, &ProcessModel::dataReady);
    QObject::connect(readProbes, &ReadProbes::updateConnectedState, processModel, &ProcessModel::updateConnectedState);

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
