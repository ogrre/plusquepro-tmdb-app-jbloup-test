# Copy .env.example to .env
cp .env.example .env

# Add TMBd_API_KEY to .env (replace YOUR_API_KEY with your actual key)
sed -i 's/^TMBD_API_KEY=.*/TMBD_API_KEY=YOUR_API_KEY/' .env

# Install PHP dependencies
sed composer install
echo "Installing PHP dependencies..."

# Create alias for Laravel Sail
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
echo "Creating alias for Laravel Sail..."

# Start Docker containers with Laravel Sail in detached mode
echo "Starting Laravel Sail containers..."
./vendor/bin/sail up -d

# Install npm dependencies
echo "Installing npm dependencies..."
./vendor/bin/sail npm install

# Compile assets with npm (development)
echo "Compiling assets for development..."
./vendor/bin/sail npm run dev

# Generate Laravel application key
echo "Generating Laravel application key..."
./vendor/bin/sail artisan key:generate

# Run database migrations
echo "Running database migrations..."
./vendor/bin/sail artisan migrate

# Populate the database with optional timeWindow argument (day or week)
echo "Populating the database..."
./vendor/bin/sail artisan database:populate --timeWindow=day

# Check for errors after each command
if [ $? -ne 0 ]; then
    echo "Error encountered. Exiting..."
    exit 1
fi

echo "Installation complete!"
