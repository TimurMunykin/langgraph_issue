FROM langchain/langgraph-api:3.11-7d5eecb
# FROM langchain/langgraph-api:3.13

ADD . /deps/__outer_langgraph_issue/src
RUN set -ex && \
    for line in '[project]' \
                'name = "langgraph_issue"' \
                'version = "0.1"' \
                '[tool.setuptools.package-data]' \
                '"*" = ["**/*"]'; do \
        echo "$line" >> /deps/__outer_langgraph_issue/pyproject.toml; \
    done

RUN PYTHONDONTWRITEBYTECODE=1 pip install --no-cache-dir -c /api/constraints.txt -e /deps/*
ENV LANGSERVE_GRAPHS='{"my_agent": "/deps/__outer_langgraph_issue/src/graph.py:graph"}'

WORKDIR /deps/__outer_langgraph_issue/src