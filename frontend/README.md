# Running **_locally_**

```bash
npm start
```

# building the container image using the default builder

```
pack build frontend-app:dev --path .
```

# running the container image

```
docker run -it --rm -v ${PWD}:/app -v /app/node_modules -p 3001:3000 -e CHOKIDAR_USEPOLLING=true frontend-app:dev
```

> -it starts the container in interactive mode, needed because react-scripts exists after start-up which will cause the container to exit

> --rm removes the container and volumes after the container exits

> -v ${PWD}:/app mounts the code into the container at /app

> -v /app/node_modules -> we want to use the container version of the node_modules

> -p 3001:3000 expose port 3000 to other Docker containers on the same network and 3001 to the host

> -e CHOKIDAR_USEPOLLING= true enables polling mechanism via chokidar (which wraps fs.watch, fs.watchFile, fsevents), needed for hot-reloading

**Note**: Visit `http://localhost:3001` to access frontend application.
