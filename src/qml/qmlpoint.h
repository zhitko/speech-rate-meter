#ifndef QMLPOINT_H
#define QMLPOINT_H

#include <QObject>

class QmlPoint : public QObject
{
    Q_GADGET
    Q_PROPERTY(double x READ getX)
    Q_PROPERTY(double y READ getY)
public:
    explicit QmlPoint();
    explicit QmlPoint(const QmlPoint& point);
    explicit QmlPoint(double x, double y, QObject *parent = nullptr);

    QmlPoint& operator=(const QmlPoint& point);

    double getX();
    double getY();

private:
    double x;
    double y;
};

Q_DECLARE_METATYPE(QmlPoint)

#endif // QMLPOINT_H
