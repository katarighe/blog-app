RSpec.describe Post, type: :model do
    before :all do
      @author = User.create(name: 'Tom')
    end
  
    it 'is valid with an existing title' do
      expect(Post.new(author: @author, title: 'Harry Potter')).to be_valid
    end
  
    it 'is not valid with a blank title' do
      expect(Post.new(author: @author, title: nil)).to_not be_valid
    end
  
    it 'is not valid with a title exceeding 250 characters' do
      expect(Post.new(author: @author, title: '0' * 251)).to_not be_valid
    end
  
    it 'is not valid with a non-numeric comments_counter' do
      expect(Post.new(author: @author, title: 'Harry Potter', comments_counter: 'five')).to_not be_valid
    end
  
    it 'is not valid with float comments_counter' do
      expect(Post.new(author: @author, title: 'Harry Potter', comments_counter: 1.5)).to_not be_valid
    end
  
    it 'is not valid with negative comments_counter' do
      expect(Post.new(author: @author, title: 'Harry Potter', comments_counter: -1)).to_not be_valid
    end
  
    it 'is valid with integer comments_counter' do
      expect(Post.new(author: @author, title: 'Harry Potter', comments_counter: 5)).to be_valid
    end
  
    context '#five_most_recent_comments' do
      before :all do
        @post = Post.create(author: @author, title: 'Title')
        8.times { |comment_i| Comment.create(user: @author, post: @post, text: (comment_i + 1).to_s) }
      end
  
      it 'returns three comments' do
        expect(@post.five_most_recent_comments.length).to eq 5
      end
  
      it 'returns most recent comments with texts 4, 5, 6, 7, 8' do
        texts = []
        @post.five_most_recent_comments.each do |comment|
          texts.push(comment.text.to_i)
        end
        expect(texts).to contain_exactly(4, 5, 6, 7, 8)
      end
    end
  
    context '#update_user_posts_counter' do
      before :all do
        8.times { Post.create(author: @author, title: 'Harry Potter') }
      end
  
      it 'keeps track of posts and equals 9' do
        expect(@author.posts_counter).to eq 9
      end
    end
  end