class Posts{
  String title;
  String description;
  int viewCount;
  String postId;
  String image;

  Posts(this.title, this.description, this.viewCount, this.postId,this.image);
}
final List<Posts> posts =[

  Posts("What is happening", 'Reloaded 1 of 898 libraries in 1,360ms (compile: 42 ms, reload: 741 ms, reassemble',10,'123','images/bagan2.jpg'),
  Posts("What is Technology", 'Reloaded 1 of 898 libraries in 1,360ms (compile: 42 ms, reload: 741 ms, reassemble',100,'123','images/bagan22.png'),
  Posts("What is Information", 'Reloaded 1 of 898 libraries in 1,360ms (compile: 42 ms, reload: 741 ms, reassemble',100,'123','images/bg1.jpg'),
  Posts("What is trending", 'Reloaded 1 of 898 libraries in 1,360ms (compile: 42 ms, reload: 741 ms, reassemble',200,'123','images/bg3.jpg'),

];