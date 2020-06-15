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

const QString SettingsKeyKSpeechRate = "speechRate/K1";
const QString SettingsKeyMinSpeechRate = "speechRate/Min";
const QString SettingsKeyMaxSpeechRate = "speechRate/Max";
const QString SettingsKeyKArticulationRate = "articulationRate/K2";
const QString SettingsKeyMinArticulationRate = "articulationRate/Min";
const QString SettingsKeyMaxArticulationRate = "articulationRate/Max";
const QString SettingsKeyKMeanPauses = "meanPauses/Max";

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
        this->setKSpeechRate(
            settings.value(SettingsKeyKSpeechRate, DefaultKSpeechRate).toDouble()
        );
        this->setMinSpeechRate(
            settings.value(SettingsKeyMinSpeechRate, DefaultMinSpeechRate).toDouble()
        );
        this->setMaxSpeechRate(
            settings.value(SettingsKeyMaxSpeechRate, DefaultMaxSpeechRate).toDouble()
        );
        this->setKArticulationRate(
            settings.value(SettingsKeyKArticulationRate, DefaultKArticulationRate).toDouble()
        );
        this->setMinArticulationRate(
            settings.value(SettingsKeyMinArticulationRate, DefaultMinArticulationRate).toDouble()
        );
        this->setMaxArticulationRate(
            settings.value(SettingsKeyMaxArticulationRate, DefaultMaxArticulationRate).toDouble()
        );
        this->setKMeanPauses(
            settings.value(SettingsKeyKMeanPauses, DefaultKMeanPauses).toDouble()
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
        SettingsKeyKSpeechRate,
        this->getKSpeechRate()
    );
    settings.setValue(
        SettingsKeyMinSpeechRate,
        this->getMinSpeechRate()
    );
    settings.setValue(
        SettingsKeyMaxSpeechRate,
        this->getMaxSpeechRate()
    );
    settings.setValue(
        SettingsKeyKArticulationRate,
        this->getKArticulationRate()
    );
    settings.setValue(
        SettingsKeyMinArticulationRate,
        this->getMinArticulationRate()
    );
    settings.setValue(
        SettingsKeyMaxArticulationRate,
        this->getMaxArticulationRate()
    );
    settings.setValue(
        SettingsKeyKMeanPauses,
        this->getKMeanPauses()
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

void Backend::setKSpeechRate(QVariant value)
{
    this->kSpeechRate = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getKSpeechRate()
{
    return this->kSpeechRate;
}

void Backend::setMinSpeechRate(QVariant value)
{
    this->minSpeechRate = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getMinSpeechRate()
{
    return this->minSpeechRate;
}

void Backend::setMaxSpeechRate(QVariant value)
{
    this->maxSpeechRate = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getMaxSpeechRate()
{
    return this->maxSpeechRate;
}

void Backend::setKArticulationRate(QVariant value)
{
    this->kArticulationRate = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getKArticulationRate()
{
    return this->kArticulationRate;
}

void Backend::setMinArticulationRate(QVariant value)
{
    this->minArticulationRate = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getMinArticulationRate()
{
    return this->minArticulationRate;
}

void Backend::setMaxArticulationRate(QVariant value)
{
    this->maxArticulationRate = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getMaxArticulationRate()
{
    return this->maxArticulationRate;
}

void Backend::setKMeanPauses(QVariant value)
{
    this->kMeanPauses = value.toDouble();
    this->saveToFile(config);
}

QVariant Backend::getKMeanPauses()
{
    return this->kMeanPauses;
}
