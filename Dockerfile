FROM chatwork/helmfile:0.108.0

ENV CBCORE_CHART_VERSION=3.11.0

ENV HELM_REPO_URL=https://charts.cloudbees.com/public/cloudbees
ENV HELM_HOME="/tmp/helm/home"
ENV FETCH_TMP="/tmp/fetch"
RUN mkdir /workspace && chmod 777 /workspace
VOLUME /workspace

RUN helm init --client-only --skip-refresh
RUN helm repo remove stable
RUN helm fetch cloudbees-core --destination "$FETCH_TMP" --version "$CBCORE_CHART_VERSION" --untar --repo "$HELM_REPO_URL"

ENTRYPOINT helm template --name cloudbees-core --values "/workspace/values.yaml" "$FETCH_TMP/cloudbees-core"





