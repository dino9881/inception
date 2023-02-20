all:
	mkdir -p ./srcs/requirements/mariadb/data
	mkdir -p ./srcs/requirements/wordpress/data
	cp ./srcs/requirements/nginx/conf/default  ./srcs/requirements/wordpress/data
	cd ./srcs && docker-compose up -d

clean:
	cd ./srcs && docker-compose down
	



fclean : 
	cd ./srcs && docker-compose down
	docker rmi $$(docker images -a -q)
	docker volume rm db_data
	docker volume rm wordpress_data
	rm -rf ./srcs/requirements/mariadb/data
	rm -rf ./srcs/requirements/wordpress/data

re :
	make fclean
	make re


.PHONY : all clean fclean re