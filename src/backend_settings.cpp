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

IntonCore::Config * Backend::getConfig(bool reload)
{
    qDebug() << "getConfig reload: " << reload;
    if (reload)
    {
        delete this->config;
        this->config = nullptr;
    }

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
    if (settings.contains(SettingsKeyDate))
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
            settings.value(SettingsKeyKSpeechRate, DefaultKSpeechRate),
            false
        );
        this->setMinSpeechRate(
            settings.value(SettingsKeyMinSpeechRate, DefaultMinSpeechRate),
            false
        );
        this->setMaxSpeechRate(
            settings.value(SettingsKeyMaxSpeechRate, DefaultMaxSpeechRate),
            false
        );
        this->setKArticulationRate(
            settings.value(SettingsKeyKArticulationRate, DefaultKArticulationRate),
            false
        );
        this->setMinArticulationRate(
            settings.value(SettingsKeyMinArticulationRate, DefaultMinArticulationRate),
            false
        );
        this->setMaxArticulationRate(
            settings.value(SettingsKeyMaxArticulationRate, DefaultMaxArticulationRate),
            false
        );
        this->setKMeanPauses(
            settings.value(SettingsKeyKMeanPauses, DefaultKMeanPauses),
            false
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

void Backend::setIntensityFrame(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityFrame(value.toUInt());
    if (save) this->saveToFile(config);
}

QVariant Backend::getIntensityShift()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensityShift();
}

void Backend::setIntensityShift(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityShift(value.toUInt());
    if (save) this->saveToFile(config);
}

QVariant Backend::getIntensitySmoothFrame()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensitySmoothFrame();
}

void Backend::setIntensitySmoothFrame(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensitySmoothFrame(value.toUInt());
    if (save) this->saveToFile(config);
}

QVariant Backend::getIntensityMaxLengthValue()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityMinimumLength();
}

void Backend::setIntensityMaxLengthValue(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityMinimumLength(value.toUInt());
    if (save) this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityMinimumLength()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityMinimumLength();
}

void Backend::setSegmentsByIntensityMinimumLength(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityMinimumLength(value.toUInt());
    if (save) this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityThresholdAbsolute()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityThresholdAbsolute();
}

void Backend::setSegmentsByIntensityThresholdAbsolute(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityThresholdAbsolute(value.toDouble());
    if (save) this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityThresholdRelative()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityThresholdRelative();
}

void Backend::setSegmentsByIntensityThresholdRelative(QVariant value, bool save)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityThresholdRelative(value.toDouble());
    if (save) this->saveToFile(config);
}

void Backend::setKSpeechRate(QVariant value, bool save)
{
    this->kSpeechRate = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getKSpeechRate()
{
    return this->kSpeechRate;
}

void Backend::setMinSpeechRate(QVariant value, bool save)
{
    this->minSpeechRate = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getMinSpeechRate()
{
    return this->minSpeechRate;
}

void Backend::setMaxSpeechRate(QVariant value, bool save)
{
    this->maxSpeechRate = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getMaxSpeechRate()
{
    return this->maxSpeechRate;
}

void Backend::setKArticulationRate(QVariant value, bool save)
{
    this->kArticulationRate = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getKArticulationRate()
{
    return this->kArticulationRate;
}

void Backend::setMinArticulationRate(QVariant value, bool save)
{
    this->minArticulationRate = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getMinArticulationRate()
{
    return this->minArticulationRate;
}

void Backend::setMaxArticulationRate(QVariant value, bool save)
{
    this->maxArticulationRate = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getMaxArticulationRate()
{
    return this->maxArticulationRate;
}

void Backend::setKMeanPauses(QVariant value, bool save)
{
    this->kMeanPauses = value.toDouble();
    if (save) this->saveToFile(config);
}

QVariant Backend::getKMeanPauses()
{
    return this->kMeanPauses;
}
