var fs = require('fs');
var os = require('os');
var exec = require('sync-exec');


var command;

if (process.argv.length > 2)
{
	command = process.argv[2];
}

if (command)
{
	switch ( command )
	{
		case "init":

			init();

			break;

		case "add-folder":

			if (process.argv.length > 3)
			{
				addFolder();
			}
			else
			{
				console.log("Usage: add-folder PATH_TO_FOLDER BTSYNC_KEY(optional) ");
			}

			break;

		case "remove-folder":

			if (process.argv.length > 3)
			{
				removeFolder();
			}
			else
			{
				console.log("Usage: remove-folder PATH_TO_FOLDER");
			}

			break;

		case "config":

			config();

			break;

		case "folders":

			folders();

			break;

		default:
		console.log("Commands: {init|add-folder|remove-folder|device-name|folders|config}");
	}
}
else
{
	console.log("Commands: {init|add-folder|remove-folder|device-name|folders|config}");
}


function init()
{
	var config = {};

	config.device_name = "btsync-docker-" + os.hostname();
	config.listening_port = 55555;
	config.check_for_updates = true;
	config.use_upnp = true;
	config.download_limit = 0;
	config.upload_limit = 0;
	config.shared_folders = [];

	console.log("Initialized config file");

	fs.writeFileSync("/btsync/config", JSON.stringify(config));
}

// restarts btsync
function start()
{

}


function addFolder()
{
	// TODO: check if folder exists
	// TODO: make sure folder is not already registered
	// TODO: make sure folder is not nested in already registered folder


	var folderPath = process.argv[3];
	var secret;

	if (process.argv.length > 4) // means we have a btsync key
	{
		secret = process.argv[4];
	}
	else
	{
		secret = exec("btsync --generate-secret").stdout;
		secret = secret.substring(0, secret.length - 2); // remove "\n"
	}

	var config = fs.readFileSync("/btsync/config");

	if ( config )
	{
		config = JSON.parse(config);

		var folder = {};

		folder.secret = secret;
		folder.dir = folderPath;

		folder.use_relay_server = true;
		folder.use_tracker = true;
		folder.use_dht = false;
		folder.search_lan = true;
		folder.use_sync_trash = true;

		config.shared_folders.push(folder);

		fs.writeFileSync("/btsync/config", JSON.stringify(config));

		console.log("Added " + folderPath);
	}
}




function removeFolder()
{
	var folderPath = process.argv[3];

	var config = fs.readFileSync("/btsync/config");

	if ( config )
	{
		config = JSON.parse(config);

		var indexToRemove = -1;

		for (var i = 0; i < config.shared_folders.length; i++)
		{
			if (folderPath == config.shared_folders[i].dir)
			{
				indexToRemove = i;
				break;
			}
		}

		if (indexToRemove != -1)
		{
			config.shared_folders.splice(indexToRemove,1);
			fs.writeFileSync("/btsync/config", JSON.stringify(config));
			console.log("Removed " + folderPath);
		}
		else
		{
			console.log(folderPath + " not found.");
		}
	}
}




function folders()
{
	var config = fs.readFileSync("/btsync/config");

	var folders = {};

	if ( config )
	{
		config = JSON.parse(config);

		for (var i = 0; i < config.shared_folders.length; i++)
		{
			console.log(config.shared_folders[i].dir)

			var secret = config.shared_folders[i].secret;

			var readonly = exec("btsync --get-ro-secret " + secret).stdout;
			
			// is secret not valid read-write exec will return:
			// <SECRET> is not valid read-write secret

			readonly = readonly.substring(0,secret.length);
			
			if ( secret != readonly )
			{
				console.log("      secret: " + secret);
				console.log("      read-only: " + readonly);
			}
			else
			{
				console.log("      secret: " + secret + " (read-only)");
			}
		}

		if (config.shared_folders.length == 0)
		{
			console.log("0 folders.");
			console.log("Use add-folder to sync folders");
		}
	}
}


function config()
{
	var config = fs.readFileSync("/btsync/config");
	
	if ( config )
	{
		config = JSON.parse(config);
		console.dir(config);
	}
	else
	{
		console.log("Config file not found");
	}
}




// sample
/*
{
  "device_name": "btsync-docker-77a067758d47",
  "listening_port": 55555,
  "check_for_updates": true,
  "use_upnp": true,
  "download_limit": 0,
  "upload_limit": 0,
  "shared_folders": [
    {
      "secret": "AHUKW5VAZOOYZRCTQTGOWYJY2RUZPGKP5",
      "dir": "/test",
      "use_relay_server": true,
      "use_tracker": true,
      "use_dht": false,
      "search_lan": true,
      "use_sync_trash": true
    }
  ]
}
*/