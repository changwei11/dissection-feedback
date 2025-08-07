# Use an official ROS2 base image (Humble on Ubuntu Jammy)
FROM osrf/ros:humble-ros-base-jammy

# Install utilities needed for Miniconda installer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget \
      bzip2 \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
      -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p ${CONDA_DIR} \
    && rm /tmp/miniconda.sh

# Ensure conda is on PATH
ENV PATH=${CONDA_DIR}/bin:$PATH

# Create and activate the 'alltracker' environment, then install Python dependencies
RUN conda create -y -n alltracker python=3.12.8 \
    && conda clean -afy

# Use bash as the default shell and activate conda environment
SHELL ["/bin/bash", "-lc"]
RUN source activate alltracker

# Copy and install Python requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Source ROS2 setup and keep the environment activated
ENTRYPOINT ["/bin/bash", "-lc", "source /opt/ros/humble/setup.bash && source activate alltracker && exec bash"]
