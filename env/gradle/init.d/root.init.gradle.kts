@file:Suppress("UnstableApiUsage")

gradle.beforeSettings {
    enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")
    caches {
        markingStrategy = MarkingStrategy.CACHEDIR_TAG
        cleanup = Cleanup.DEFAULT
        buildCache.setRemoveUnusedEntriesAfterDays(1)
        downloadedResources.setRemoveUnusedEntriesAfterDays(1)
        createdResources.setRemoveUnusedEntriesAfterDays(1)
    }
    buildCache {
        local {
            isPush = true
            isEnabled = true
            directory = file("${gradle.gradleUserHomeDir}/build-cache")
        }
    }
    pluginManagement {
        repositories {
            google {
                mavenContent {
                    includeGroupAndSubgroups("androidx")
                    includeGroupAndSubgroups("com.android")
                    includeGroupAndSubgroups("com.google")
                }
            }
            mavenCentral()
            gradlePluginPortal()
        }
    }
    dependencyResolutionManagement {
        repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
        repositories {
            google {
                mavenContent {
                    includeGroupAndSubgroups("androidx")
                    includeGroupAndSubgroups("com.android")
                    includeGroupAndSubgroups("com.google")
                }
            }
            mavenCentral()
            gradlePluginPortal()
        }
    }
}