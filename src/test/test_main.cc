#include <glog/logging.h>
#include <gtest/gtest.h>
#include "base/at_exit.h"

int main(int argc, char* argv[])
{
    base::AtExitManager exit_manager;
    google::InitGoogleLogging(argv[0]);
    testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}
