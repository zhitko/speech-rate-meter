#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QFileInfo>
#include <QStringList>
#include <QDirIterator>
#include <QDir>

#include "backend.h"
#include "applicationconfig.h"
#include "qml/qmlfileinfo.h"
#include "qml/qmlpoint.h"
#include "3party/RadialBar/radialbar.h"

void cleanDataDir();

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<RadialBar>("RadialBar", 1, 0, "RadialBar");
    qmlRegisterType<Backend>("intondemo.backend", 1, 0, "Backend");
    qRegisterMetaType<QmlFileInfo>("FileInfo");
    qRegisterMetaType<QmlPoint>("Point");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    auto result = QApplication::exec();

    cleanDataDir();

    return result;
}

void cleanDataDir()
{
    QDir dataDir(ApplicationConfig::GetFullDataPath());
    QStringList allFiles = dataDir.entryList(ApplicationConfig::WaveFileFilter, QDir::NoDotAndDotDot | QDir::Files);

    foreach(auto file, allFiles)
    {
        QDir dir;
        dir.remove(dataDir.absoluteFilePath(file));
    }
}
