def youtube_channel_hash
  {
    'id' => '42',
    'snippet' => {
      'title' => 'Frank Underwood',
      'description' => 'Awesome description',
      'thumbnails' => { 'high' => 'http://thumbnail' }
    },
    'contentDetails' => {
      'relatedPlaylists' => { 'uploads' => '42-xy12' }
    }
  }
end

def youtube_video_hash
  {
    'id' => '42',
    'snippet' => {
      'title' => 'Frank Underwood',
      'description' => 'Awesome video',
      'thumbnails' => {
        'maxres' => { 'url' => 'http://thumbnail' }
      }
    },
    'contentDetails' => {
      'duration' => 'PT8M24S',
      'definition' => 'hd'
    },
    'statistics' => { 'view_count' => '200' }
  }
end

def youtube_playlist_item_hash
  {
    'id' => '42',
    'snippet' => {
      'title' => 'Frank Underwood',
      'description' => 'Awesome video',
      'thumbnails' => {
        'maxres' => { 'url' => 'http://thumbnail' }
      },
      'resourceId' => { 'videoId' => '12' }
    }
  }
end