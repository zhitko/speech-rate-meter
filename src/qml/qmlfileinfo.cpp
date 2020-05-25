#include "qmlfileinfo.h"

#include <QFileInfo>

QmlFileInfo::QmlFileInfo() : QObject(), path("")
{

}

QmlFileInfo::QmlFileInfo(const QmlFileInfo &fileInfo) : QObject(fileInfo.parent()), path(fileInfo.path)
{

}

QmlFileInfo::QmlFileInfo(QString path, QObject *parent) : QObject(parent), path(path)
{

}

QmlFileInfo &QmlFileInfo::operator=(const QmlFileInfo &fileInfo)
{
    this->path = fileInfo.path;
    return *this;
}

QString QmlFileInfo::getPath()
{
    return this->path;
}

QString QmlFileInfo::getName()
{
    QFileInfo fileInfo(this->path);
    return fileInfo.fileName();
}
