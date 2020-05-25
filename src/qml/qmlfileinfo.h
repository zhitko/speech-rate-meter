#ifndef QMLFILEINFO_H
#define QMLFILEINFO_H

#include <QObject>

class QmlFileInfo : public QObject
{
    Q_GADGET
    Q_PROPERTY(QString name READ getName)
    Q_PROPERTY(QString path READ getPath)
public:
    explicit QmlFileInfo();
    explicit QmlFileInfo(const QmlFileInfo& fileInfo);
    explicit QmlFileInfo(QString path, QObject *parent = nullptr);

    QmlFileInfo& operator=(const QmlFileInfo& fileInfo);

    QString getPath();
    QString getName();

private:
    QString path;
};

Q_DECLARE_METATYPE(QmlFileInfo)

#endif // QMLFILEINFO_H
