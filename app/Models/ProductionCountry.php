<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class ProductionCountry extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'iso_3166_1',
        'name'
    ];

    /**
     * The movies that belong to the production company.
     */
    public function movies(): BelongsToMany
    {
        return $this->belongsToMany(Movie::class);
    }
}
