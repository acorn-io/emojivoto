ARG image_repo=""
ARG image_tag=""
FROM ${image_repo}:emojivoto-svc-base-${image_tag}

ARG svc_name

COPY $svc_name/target/ /usr/local/bin/

# ARG variables arent available for ENTRYPOINT
ENV SVC_NAME $svc_name
ENTRYPOINT cd /usr/local/bin && $SVC_NAME
