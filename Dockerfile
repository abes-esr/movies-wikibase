FROM wikibase/wikibase-bundle:1.39.1-wmde.11 as movies-wikibase-image

RUN git clone --recurse-submodules https://gerrit.wikimedia.org/r/mediawiki/extensions/PluggableAuth.git -b REL1_39 /var/www/html/extensions/PluggableAuth 
RUN git clone --recurse-submodules https://gerrit.wikimedia.org/r/mediawiki/extensions/LDAPAuthorization.git -b REL1_39 /var/www/html/extensions/LDAPAuthorization 
RUN git clone --recurse-submodules https://gerrit.wikimedia.org/r/mediawiki/extensions/LDAPProvider.git -b REL1_39 /var/www/html/extensions/LDAPProvider 
RUN git clone --recurse-submodules https://gerrit.wikimedia.org/r/mediawiki/extensions/LDAPAuthentication2.git -b REL1_39 /var/www/html/extensions/LDAPAuthentication2 
RUN git clone --recurse-submodules https://gerrit.wikimedia.org/r/mediawiki/extensions/LDAPUserInfo.git -b REL1_39 /var/www/html/extensions/LDAPUserInfo 
RUN git clone --recurse-submodules https://gerrit.wikimedia.org/r/mediawiki/extensions/LDAPGroups.git -b REL1_39 /var/www/html/extensions/LDAPGroups
RUN git clone https://github.com/DaSchTour/matomo-mediawiki-extension.git -b v5.0.0 /var/www/html/extensions/Matomo

RUN apt-get update && \
    apt-get install libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

RUN touch /opt/act.test

#https://github.com/DaSchTour/matomo-mediawiki-extension?tab=readme-ov-file#troubleshooting
#https://gerrit.wikimedia.org/r/c/mediawiki/core/+/952569/4/includes/Output/OutputPage.php
COPY OutputPage.php /var/www/html/includes/
