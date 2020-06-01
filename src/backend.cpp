#include "backend.h"

#include <cmath>

#include <QDebug>
#include <QDir>
#include <QGuiApplication>
#include <QSound>
#include <QFileDialog>
#include <QStandardPaths>

#include <intoncore.h>
#include <utils.h>

#include "applicationconfig.h"
#include "recorder.h"
#include "qml/qmlfileinfo.h"
#include "qml/qmlpoint.h"


const int WAVE_LENGTH = 1000;

Backend::Backend(QObject *parent)
    : QObject(parent), core(nullptr), config(nullptr),
    kCoeficient(DefaultKCoeficient), mCoeficient(DefaultMCoeficient),
    minSpeechRate(70), maxSpeechRate(210)
{
    this->path = "";

    this->recorder = Recorder::getInstance();
}

Backend::~Backend()
{
    delete core;
}

QVariantList Backend::getWaveFilesList()
{
    QDir dataDir(ApplicationConfig::GetFullDataPath());
    QStringList allFiles = dataDir.entryList(ApplicationConfig::WaveFileFilter, QDir::NoDotAndDotDot | QDir::Files);
    qDebug() << "Found files: " << allFiles;

    QVariantList fileList;

    foreach(auto file, allFiles)
    {
        QmlFileInfo info(dataDir.absoluteFilePath(file));
        qDebug() << "File: " << info.getName() << " : " << info.getPath();

        fileList.append(QVariant::fromValue(info));
    }

    return fileList;
}

void Backend::deleteWaveFile(QString path)
{
    qDebug() << "Delete file " << path;
    QFile file (path.toLocal8Bit());
    file.remove();
}

void Backend::playWaveFile(QString path)
{
    QSound::play(path);
}

QString Backend::startStopRecordWaveFile()
{
    QString path = "";
    if (!this->recorder->isRecording())
    {
        path = this->recorder->startRecording();
    } else {
        path = this->recorder->stopRecording();
    }

    return path;
}

QString Backend::openFileDialog()
{
    auto fileName = QFileDialog::getOpenFileName(nullptr,
        tr("Open File"),
        ".",
        tr("Wave (*.wav)"));
    return fileName;
}

QVariantList Backend::getWaveData(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getWaveNormalized();
    auto resized_data = IntonCore::resizeVectorByMinMax(data, WAVE_LENGTH);
    qDebug() << "Wave file size " << data.size();

    QVariantList waveData;

    for (ulong i=0; i<resized_data.size(); i++) {
        waveData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return waveData;
}

QVariantList Backend::getIntensity(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getIntensityNormalized();
    auto resized_data = IntonCore::resizeVector(data, WAVE_LENGTH);
    qDebug() << "Intensity size " << data.size();

    QVariantList intensityData;

    for (ulong i=0; i<resized_data.size(); i++) {
        intensityData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return intensityData;
}

QVariantList Backend::getIntensitySmoothed(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getIntensityNormalizedSmoothed();
    auto resized_data = IntonCore::resizeVector(data, WAVE_LENGTH);
    qDebug() << "Intensity smoothed size " << data.size();

    QVariantList intensityData;

    for (ulong i=0; i<resized_data.size(); i++) {
        intensityData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return intensityData;
}

QVariantList Backend::getWaveSegmantData(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getWaveNormalized();
    int from = static_cast<int>(std::ceil(data.size() * std::min(from_percent, to_percent)));
    int to = static_cast<int>(std::ceil(data.size() * std::max(from_percent, to_percent)));
    std::vector<double>::const_iterator first = data.begin() + from;
    std::vector<double>::const_iterator last = data.begin() + to;
    std::vector<double>  cutted_data(first, last);
    auto resized_data = IntonCore::resizeVectorByMinMax(cutted_data, WAVE_LENGTH);

    qDebug() << "Wave file size " << data.size();

    QVariantList waveData;

    for (ulong i=0; i<resized_data.size(); i++) {
        waveData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return waveData;
}

QVariantList Backend::getSegmentsP(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto data = storage->getManualSegmentsP();
    qDebug() << "Segments P count " << data.size();

    QVariantList segments;

    for (auto &it : data)
    {
        it.first = IntonCore::normalizeValue(it.first, wave.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, wave.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsN(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto data = storage->getManualSegmentsN();
    qDebug() << "Segments N count " << data.size();

    QVariantList segments;

    for (auto &it: data)
    {
        it.first = IntonCore::normalizeValue(it.first, wave.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, wave.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsT(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto data = storage->getManualSegmentsT();
    qDebug() << "Segments T count " << data.size();

    QVariantList segments;

    for (auto &it: data)
    {
        it.first = IntonCore::normalizeValue(it.first, wave.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, wave.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsByIntensity(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto intensity = storage->getIntensity();

    auto data = storage->getAutoSegmentsByIntensitySmoothed();
    qDebug() << "Segments by intensity count " << data.size();

    QVariantList segments;

    for (auto &it: data)
    {
        it.first = IntonCore::normalizeValue(it.first, intensity.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, intensity.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsByIntensityMask(QString path, double from_percent, double to_percent)
{
    qDebug() << "getSegmentsByIntensityMask " << from_percent << " " << to_percent;
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto intensity = storage->getIntensity();

    auto data = storage->getAutoSegmentsByIntensitySmoothedMask();

    qDebug() << "Segments mask by intensity count " << data.size();
    int from = static_cast<int>(std::round(data.size() * std::min(from_percent, to_percent)));
    qDebug() << "from " << from;
    int to = static_cast<int>(std::round(data.size() * std::max(from_percent, to_percent)));
    qDebug() << "to " << to;

    int count = 20;

    int segment_size = 1.0 * (to - from) / count;
    qDebug() << "segment_size " << segment_size;

    QVariantList result;

    int value = 0;
    for (int i=0; i<count; i++)
    {
        value = 0;
        for (int j=0; j<segment_size; j++) {
            if (from+i*segment_size+j < data.size())
            {
                value += data[from+i*segment_size+j];
            }
        }
        result.append(QVariant::fromValue(value));
    }

    return result;

}

QVariant Backend::getWaveLength(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto select = abs(to_percent - from_percent);

    return QVariant::fromValue(1.0 * wave.size() / ApplicationConfig::RecordingFrequency * select);
}

QVariant Backend::getVowelsLength(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    int from = static_cast<int>(std::ceil(from_percent * segments_mask.size()));
    int to = static_cast<int>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    int count = 0;
    for (int i=from; i<to; i++)
    {
        if (segments_mask[i]) count++;
    }

    return QVariant::fromValue(storage->convertIntensityPointsToSec(count));
}

QVariant Backend::getConsonantsAndSilenceCount(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothedInverted();

    auto intensity = storage->getIntensity();
    auto from = from_percent * intensity.size();
    auto to = to_percent * intensity.size();
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    int count = 0;
    for (auto &it: segments)
    {
        qDebug() << "Segment inverted first: " << it.first;
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            count++;
        }
    }

    return QVariant::fromValue(count);
}

QVariant Backend::getConsonantsAndSilenceLength(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    int from = static_cast<int>(std::ceil(from_percent * segments_mask.size()));
    int to = static_cast<int>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    int count = 0;
    for (int i=from; i<to; i++)
    {
        if (!segments_mask[i]) count++;
    }

    return QVariant::fromValue(storage->convertIntensityPointsToSec(count));
}

QVariant Backend::getVowelsCount(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto intensity = storage->getIntensity();
    auto from = from_percent * intensity.size();
    auto to = to_percent * intensity.size();
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    int count = 0;
    for (auto &it: segments)
    {
        qDebug() << "Segment first: " << it.first;
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            count++;
        }
    }

    return QVariant::fromValue(count);

}

QVariant Backend::getSegmentsVariance(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    int mx2 = 0;
    int mx = 0;
    for (uint32_t i=from; i<to; i++)
    {
        if (segments_mask[i]) mx += i;
        if (segments_mask[i]) mx2 += i * i;
    }

    return QVariant::fromValue(storage->convertIntensityPointsToSec(mx2 - mx*mx));

}

QVariant Backend::getVowelsMeanValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    double result = 0.0;
    int count = 0;
    for (auto &it: segments)
    {
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            count++;
            result += it.second;
        }
    }

    result /= count;

    return QVariant::fromValue(storage->convertIntensityPointsToSec(result));
}

QVariant Backend::getVowelsMedianValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    std::vector<int> selected_segments;

    for (auto &it: segments)
    {
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            selected_segments.push_back(it.second);
        }
    }

    sort(selected_segments.begin(), selected_segments.end());

    int median = IntonCore::getMedianValue(selected_segments);

    return QVariant::fromValue(storage->convertIntensityPointsToSec(median));
}

QVariant Backend::getConsonantsAndSilenceMeanValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothedInverted();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    double result = 0.0;
    int count = 0;
    for (auto &it: segments)
    {
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            count++;
            result += it.second;
        }
    }

    result /= count;

    return QVariant::fromValue(storage->convertIntensityPointsToSec(result));
}

QVariant Backend::getConsonantsAndSilenceMedianValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothedInverted();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "from: " << from;
    qDebug() << "to: " << to;

    std::vector<int> selected_segments;

    for (auto &it: segments)
    {
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            selected_segments.push_back(it.second);
        }
    }

    sort(selected_segments.begin(), selected_segments.end());

    int median = IntonCore::getMedianValue(selected_segments);

    return QVariant::fromValue(storage->convertIntensityPointsToSec(median));
}

QVariant Backend::getVowelsRate(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto waveLength = this->getWaveLength(path, from_percent, to_percent).toDouble();
    auto segmentsCount = this->getVowelsCount(path, from_percent, to_percent).toDouble();

    return QVariant::fromValue(segmentsCount / waveLength);
}

QVariant Backend::getNumberOfWords(QString path, double from_percent, double to_percent)
{
    auto vowelsCount = this->getVowelsCount(path, from_percent, to_percent);
    double numberOfWords = vowelsCount.toInt() / this->mCoeficient;

    return QVariant::fromValue(numberOfWords);
}

QVariant Backend::getSpeechRate(QString path, double from_percent, double to_percent)
{
    auto numberOfWords = this->getNumberOfWords(path, from_percent, to_percent);
    auto waveLength = this->getWaveLength(path, from_percent, to_percent);
    double speechRate = 60.0 * numberOfWords.toDouble() / waveLength.toInt();
    return QVariant::fromValue(speechRate);
}

QVariant Backend::getMeanDurationOfPauses(QString path, double from_percent, double to_percent)
{
    auto consonantsAndSilenceMean = this->getConsonantsAndSilenceMeanValue(path, from_percent, to_percent);
    auto consonantsAndSilenceMedian = this->getConsonantsAndSilenceMedianValue(path, from_percent, to_percent);
    double meanDurationOfPauses = abs(consonantsAndSilenceMean.toDouble() - consonantsAndSilenceMedian.toDouble()) * this->kCoeficient;
    return QVariant::fromValue(meanDurationOfPauses);
}

QString Backend::getPath()
{
    return this->path;
}

void Backend::setPath(const QString &path)
{
    qDebug() << "path = " << path;
    this->path = path;

    this->initializeCore(true);
}

void Backend::initializeCore(bool reinit)
{
    if (this->core != nullptr && !reinit) return;

    delete this->core;
    IntonCore::Config * config = this->getConfig();
    this->core = new IntonCore::Core(this->path.toLocal8Bit().toStdString(), config);
}

void Backend::initializeCore(const QString& path)
{
    qDebug() << "path: ";
    qDebug() << this->path;
    qDebug() << path;
    if (this->path == path) return;
    this->setPath(path);
}
