#include "backend.h"

#include <QDebug>
#include <QSettings>
#include <QVariant>
#include <QDate>

#include <config.h>

#include "applicationconfig.h"


const QString SettingsKeyDate = "date";
const QString SettingsKeyIntensityFrame = "intensity/frame";
const QString SettingsKeyIntensityShift = "intensity/shift";
const QString SettingsKeyIntensitySmoothFrame = "intensity/smoothFrame";
const QString SettingsKeySegmentsByIntensityMinimumLength = "segmentsByIntensity/minimumLength";
const QString SettingsKeySegmentsByIntensityThresholdAbsolute = "segmentsByIntensity/thresholdAbsolute";
const QString SettingsKeySegmentsByIntensityThresholdRelative = "segmentsByIntensity/thresholdRelative";
const QString SettingsKeySpeechRateKCoeficient = "speechRate/K";
const QString SettingsKeySpeechRateMCoeficient = "speechRate/M";

IntonCore::Config * Backend::getConfig()
{
    qDebug() << "getConfig";
    if (this->config == nullptr)
    {
        this->config = new IntonCore::Config();
        this->loadFromFile(config);
    }

    return this->config;
}

void Backend::loadFromFile(IntonCore::Config *config)
{
    QSettings settings(ApplicationConfig::GetFullSettingsPath(), QSettings::IniFormat);
    if (settings.contains("date"))
    {
        qDebug() << "Load config file: " << settings.fileName();
        config->setIntensityFrame(
            settings.value(SettingsKeyIntensityFrame).toUInt()
        );
        config->setIntensityShift(
            settings.value(SettingsKeyIntensityShift).toUInt()
        );
        config->setIntensitySmoothFrame(
            settings.value(SettingsKeyIntensitySmoothFrame).toUInt()
        );
        config->setSegmentsByIntensityMinimumLength(
            settings.value(SettingsKeySegmentsByIntensityMinimumLength).toUInt()
        );
        config->setSegmentsByIntensityThresholdAbsolute(
            settings.value(SettingsKeySegmentsByIntensityThresholdAbsolute).toDouble()
        );
        config->setSegmentsByIntensityThresholdRelative(
            settings.value(SettingsKeySegmentsByIntensityThresholdRelative).toDouble()
        );
        this->setKCoeficient(
            settings.value(SettingsKeySpeechRateKCoeficient, DefaultKCoeficient).toDouble()
        );
        this->setMCoeficient(
            settings.value(SettingsKeySpeechRateMCoeficient, DefaultMCoeficient).toDouble()
        );
    }
}

void Backend::saveToFile(IntonCore::Config *config)
{
    QSettings settings(ApplicationConfig::GetFullSettingsPath(), QSettings::IniFormat);

    qDebug() << "Create new config file: " << settings.fileName();
    settings.setValue(
        SettingsKeyDate,
        QDate()
    );
    settings.setValue(
        SettingsKeyIntensityFrame,
        config->intensityFrame()
    );
    settings.setValue(
        SettingsKeyIntensityShift,
        config->intensityShift()
    );
    settings.setValue(
        SettingsKeyIntensitySmoothFrame,
        config->intensitySmoothFrame()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityMinimumLength,
        config->segmentsByIntensityMinimumLength()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityThresholdAbsolute,
        config->segmentsByIntensityThresholdAbsolute()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityThresholdRelative,
        config->segmentsByIntensityThresholdRelative()
    );
    settings.setValue(
        SettingsKeySpeechRateKCoeficient,
        this->getKCoeficient()
    );
    settings.setValue(
        SettingsKeySpeechRateMCoeficient,
        this->getMCoeficient()
    );
    settings.sync();
}

QVariant Backend::getIntensityFrame()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensityFrame();
}

void Backend::setIntensityFrame(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityFrame(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensityShift()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensityShift();
}

void Backend::setIntensityShift(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityShift(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensitySmoothFrame()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensitySmoothFrame();
}

void Backend::setIntensitySmoothFrame(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensitySmoothFrame(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensityMaxLengthValue()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityMinimumLength();
}

void Backend::setIntensityMaxLengthValue(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityMinimumLength(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityMinimumLength()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityMinimumLength();
}

void Backend::setSegmentsByIntensityMinimumLength(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityMinimumLength(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityThresholdAbsolute()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityThresholdAbsolute();
}

void Backend::setSegmentsByIntensityThresholdAbsolute(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityThresholdAbsolute(value.toDouble());
    this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityThresholdRelative()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityThresholdRelative();
}

void Backend::setSegmentsByIntensityThresholdRelative(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityThresholdRelative(value.toDouble());
    this->saveToFile(config);
}

QVariant Backend::getKCoeficient()
{
    return this->kCoeficient;
}

void Backend::setKCoeficient(QVariant value)
{
    this->kCoeficient = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getMCoeficient()
{
    return this->mCoeficient;
}

void Backend::setMCoeficient(QVariant value)
{
    this->mCoeficient = value.toDouble();
    this->saveToFile(config);
}
