#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>
#include <QString>

#include "notificationhandler.h"



int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);


    QObject::connect(NotificationHandler::Instance(), &NotificationHandler::tokenChanged, [&](const QByteArray &token) {
        qDebug() << "TOKEN (HEX):\t" << token.toHex();
        qDebug() << "TOKEN (B64):\t" << token.toBase64();
    });

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("notification", NotificationHandler::Instance());

    engine.load(url);

    return app.exec();
}
