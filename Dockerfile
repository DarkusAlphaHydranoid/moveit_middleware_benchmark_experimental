FROM ros:rolling

RUN apt-get update && \
    apt install wget -y

RUN mkdir ws/src -p

RUN . /opt/ros/rolling/setup.sh && \
    cd ws/src && \
    git clone https://github.com/DarkusAlphaHydranoid/moveit_middleware_benchmark_experimental.git && \
    vcs import < moveit_middleware_benchmark/moveit_middleware_benchmark.repos --recursive

RUN . /opt/ros/rolling/setup.sh && \
    cd ws && \
    rosdep update --rosdistro=$ROS_DISTRO && \
    apt-get update && \
    apt upgrade -y && \
    rosdep install --from-paths src --ignore-src -r -y

RUN . /opt/ros/rolling/setup.sh && \
    cd ws && \
    colcon build --mixin release --packages-skip test_dynmsg dynmsg_demo
