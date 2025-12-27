
import React, { useState } from 'react';
import { ICONS } from '../constants';
import { ForumPost } from '../types';

const Community: React.FC = () => {
  const [posts, setPosts] = useState<ForumPost[]>([
    {
      id: '1',
      author: 'Ebiere P.',
      title: 'How can we support local fishermen in Amassoma?',
      content: 'I have been thinking about ways we can improve the cold storage infrastructure for our local fishermen. Any ideas?',
      timestamp: '2 hours ago',
      likes: 24,
      replies: 12
    },
    {
      id: '2',
      author: 'Tari O.',
      title: 'Seeking old photos of Amassoma market (1980s)',
      content: 'Doing some research for a school project and would love to see how the town looked back then. Please share!',
      timestamp: '5 hours ago',
      likes: 15,
      replies: 8
    }
  ]);

  const [newTitle, setNewTitle] = useState('');
  const [newContent, setNewContent] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!newTitle || !newContent) return;
    
    const newPost: ForumPost = {
      id: Date.now().toString(),
      author: 'Guest User',
      title: newTitle,
      content: newContent,
      timestamp: 'Just now',
      likes: 0,
      replies: 0
    };

    setPosts([newPost, ...posts]);
    setNewTitle('');
    setNewContent('');
  };

  return (
    <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
      <div className="lg:col-span-3 space-y-6">
        <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
          <h2 className="text-xl font-bold mb-4">Start a Discussion</h2>
          <form onSubmit={handleSubmit} className="space-y-4">
            <input
              type="text"
              placeholder="Topic title..."
              className="w-full p-3 rounded-xl border border-slate-200 focus:ring-2 focus:ring-blue-500 outline-none"
              value={newTitle}
              onChange={(e) => setNewTitle(e.target.value)}
            />
            <textarea
              placeholder="What's on your mind?"
              className="w-full p-3 rounded-xl border border-slate-200 focus:ring-2 focus:ring-blue-500 outline-none min-h-[100px]"
              value={newContent}
              onChange={(e) => setNewContent(e.target.value)}
            />
            <div className="flex justify-end">
              <button
                type="submit"
                className="bg-blue-600 text-white px-6 py-2 rounded-xl font-semibold hover:bg-blue-700 transition-colors flex items-center gap-2"
              >
                Post Topic <ICONS.Send />
              </button>
            </div>
          </form>
        </div>

        <div className="space-y-4">
          <h3 className="text-xl font-bold text-slate-800">Recent Debates & Topics</h3>
          {posts.map((post) => (
            <div key={post.id} className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200 hover:border-blue-200 transition-colors">
              <div className="flex items-center gap-3 mb-3">
                <div className="w-10 h-10 rounded-full bg-slate-200 flex items-center justify-center font-bold text-slate-500">
                  {post.author[0]}
                </div>
                <div>
                  <p className="font-bold text-slate-900">{post.author}</p>
                  <p className="text-xs text-slate-400">{post.timestamp}</p>
                </div>
              </div>
              <h4 className="text-lg font-bold mb-2 hover:text-blue-600 cursor-pointer">{post.title}</h4>
              <p className="text-slate-600 mb-4 line-clamp-2">{post.content}</p>
              <div className="flex items-center gap-6 border-t pt-4">
                <button className="flex items-center gap-2 text-slate-500 hover:text-red-500 text-sm transition-colors">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
                  {post.likes}
                </button>
                <button className="flex items-center gap-2 text-slate-500 hover:text-blue-500 text-sm transition-colors">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                  {post.replies} Replies
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="space-y-6">
        <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
          <h3 className="font-bold mb-4">Trending Tags</h3>
          <div className="flex flex-wrap gap-2">
            {['#Education', '#Fisheries', '#NDU', '#Culture', '#Amassoma2024'].map(tag => (
              <span key={tag} className="bg-slate-50 text-slate-600 px-3 py-1 rounded-full text-sm font-medium border border-slate-100 cursor-pointer hover:bg-blue-50 hover:text-blue-600">
                {tag}
              </span >
            ))}
          </div>
        </div>

        <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
          <h3 className="font-bold mb-4">Active Members</h3>
          <div className="space-y-4">
            {['Kurobiari', 'Tariere', 'Ebi', 'Preye'].map(name => (
              <div key={name} className="flex items-center gap-3">
                <div className="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-600 font-bold text-xs">{name[0]}</div>
                <span className="text-sm font-medium text-slate-700">{name}</span>
                <span className="ml-auto w-2 h-2 rounded-full bg-green-500"></span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Community;
