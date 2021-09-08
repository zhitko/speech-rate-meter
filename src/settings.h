#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

const double DefaultKSpeechRate = 0.79;
const double DefaultMeanValueDegry = 3.0;
const double DefaultMinSpeechRate = 70;
const double DefaultMaxSpeechRate = 210;
const double DefaultKArticulationRate = 1.2;
const double DefaultMinArticulationRate = 70;
const double DefaultMaxArticulationRate = 210;
const double DefaultKMeanPauses = 0.26;
const double DefaultKFillerSounds = 100;
const double DefaultMinFillerSounds = 120;
const double DefaultMaxFillerSounds = 240;

const int DefaultFrame = 240;
const int DefaultShift = 120;
const int DefaultSmoothFrame = 120;
const int DefaultSegmentLimit = 15;


namespace IntonCore {
class Config;
}

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = nullptr);
    explicit Settings(const Settings& settings);
    ~Settings();
    Q_INVOKABLE static Settings* getInstance(QObject *parent = nullptr);

    IntonCore::Config * getConfig();

    Q_INVOKABLE QVariant getIntensityFrame();
    Q_INVOKABLE void setIntensityFrame(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getIntensityShift();
    Q_INVOKABLE void setIntensityShift(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getIntensitySmoothFrame();
    Q_INVOKABLE void setIntensitySmoothFrame(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getIntensityMaxLengthValue();
    Q_INVOKABLE void setIntensityMaxLengthValue(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getSegmentsByIntensityMinimumLength();
    Q_INVOKABLE void setSegmentsByIntensityMinimumLength(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getSegmentsByIntensityThresholdAbsolute();
    Q_INVOKABLE void setSegmentsByIntensityThresholdAbsolute(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getSegmentsByIntensityThresholdRelative();
    Q_INVOKABLE void setSegmentsByIntensityThresholdRelative(QVariant value, bool save = true);

    Q_INVOKABLE void setMeanValueDegry(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMeanValueDegry();
    Q_INVOKABLE void setKSpeechRate(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getKSpeechRate();
    Q_INVOKABLE void setMinSpeechRate(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMinSpeechRate();
    Q_INVOKABLE void setMaxSpeechRate(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMaxSpeechRate();
    Q_INVOKABLE void setKArticulationRate(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getKArticulationRate();
    Q_INVOKABLE void setMinArticulationRate(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMinArticulationRate();
    Q_INVOKABLE void setMaxArticulationRate(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMaxArticulationRate();
    Q_INVOKABLE void setKMeanPauses(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getKMeanPauses();
    Q_INVOKABLE void setKFillerSounds(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getKFillerSounds();
    Q_INVOKABLE void setMinFillerSounds(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMinFillerSounds();
    Q_INVOKABLE void setMaxFillerSounds(QVariant value, bool save = true);
    Q_INVOKABLE QVariant getMaxFillerSounds();

    Q_INVOKABLE void setAdvanced(QVariant value);
    Q_INVOKABLE QVariant getAdvanced();

private:
    IntonCore::Config *config;

    double meanValueDegry;
    double kSpeechRate;
    double minSpeechRate;
    double maxSpeechRate;
    double kArticulationRate;
    double minArticulationRate;
    double maxArticulationRate;
    double kMeanPauses;
    double minFillerSounds;
    double maxFillerSounds;
    double kFillerSounds;

    void loadFromFile(IntonCore::Config *config);
    void saveToFile(IntonCore::Config *config);

signals:

};

#endif // SETTINGS_H
