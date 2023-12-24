# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Cutku <cutku@student.42heilbronn.de>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/17 19:03:53 by Cutku             #+#    #+#              #
#    Updated: 2023/12/24 17:42:35 by Cutku            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE = srcs/docker-compose.yml

DB_VOLUME = ./data/mysql
WP_VOLUME = ./data/wordpress

all: run

run:
	@mkdir -p $(DB_VOLUME)
	@mkdir -p $(WP_VOLUME)
	@docker compose -f $(COMPOSE_FILE) up -d --build 

rm-volume:
	rm -rf $(DB_VOLUME)
	rm -rf $(WP_VOLUME)

prune:
	@docker container prune
	@docker image prune -a
	@docker volume prune

fclean:
	docker compose -f $(COMPOSE_FILE) down
	# @sudo rm -rf $(DB_VOLUME)
	# @sudo rm -rf $(WP_VOLUME)
	# @sudo docker image rm -f srcs_nginx
	# @sudo docker image rm -f srcs_wordpress
	# @sudo docker image rm -f srcs_mariadb


re: fclean run
	
.PHONY: all run rm-volume prune fclean re