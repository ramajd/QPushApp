#ifndef NOTIFICATIONHANDLER_H
#define NOTIFICATIONHANDLER_H

#include <QObject>
#include <QByteArray>
#include <QString>

class NotificationHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QByteArray token READ token WRITE setToken NOTIFY tokenChanged)
public:
    static NotificationHandler *Instance();

    QByteArray token() const;
    void setToken(const QByteArray &newToken);

    void submitError(const QString &errorMessage);
    void submitMessage(const QString &message);
    void submitLog(const QString &logMessage);

    Q_INVOKABLE QString tokenHex() const;
    Q_INVOKABLE QString tokenBase64() const;

protected:
    explicit NotificationHandler(QObject *parent = nullptr);

signals:
    void tokenChanged(const QByteArray &token);
    void messageReceived(const QString &message);
    void errorOccurred(const QString &errorMessagge);
    void logSubmitted(const QString &logMessage);

private:
    static NotificationHandler* _instance;

    QByteArray m_token;
};

#endif // NOTIFICATIONHANDLER_H
