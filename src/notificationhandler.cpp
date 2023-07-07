#include "notificationhandler.h"

#include <QDebug>

NotificationHandler* NotificationHandler::_instance = nullptr;

NotificationHandler::NotificationHandler(QObject *parent)
    : QObject{parent}
{}

NotificationHandler *NotificationHandler::Instance()
{
    if (_instance == nullptr) {
        _instance = new NotificationHandler(nullptr);
    }
    return _instance;
}

QByteArray NotificationHandler::token() const
{
    return m_token;
}

void NotificationHandler::setToken(const QByteArray &newToken)
{
    if (m_token == newToken)
        return;
    m_token = newToken;
    emit tokenChanged(m_token);
}

void NotificationHandler::submitError(const QString &errorMessage)
{
    emit errorOccurred(errorMessage);
}

void NotificationHandler::submitMessage(const QString &message)
{
    emit messageReceived(message);
}

void NotificationHandler::submitLog(const QString &logMessage)
{
    qDebug() << "NATIVE: " << logMessage;
    emit logSubmitted(logMessage);
}

QString NotificationHandler::tokenBase64() const
{
    return m_token.toBase64();
}

QString NotificationHandler::tokenHex() const
{
    return m_token.toHex();
}
