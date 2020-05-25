#include "qmlpoint.h"

QmlPoint::QmlPoint(double x, double y, QObject *parent)
    : QObject(parent), x(x), y(y)
{

}

QmlPoint::QmlPoint(): QObject(), x(0), y(0)
{

}

QmlPoint::QmlPoint(const QmlPoint &QmlPoint)
    : QObject(QmlPoint.parent()), x(QmlPoint.x), y(QmlPoint.y)
{

}

QmlPoint &QmlPoint::operator=(const QmlPoint &QmlPoint)
{
    this->x = QmlPoint.x;
    this->y = QmlPoint.y;
    return *this;
}

double QmlPoint::getX()
{
    return this->x;
}

double QmlPoint::getY()
{
    return this->y;
}
