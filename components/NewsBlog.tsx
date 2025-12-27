
import React from 'react';
import { MOCK_NEWS } from '../constants';

const NewsBlog: React.FC = () => {
  return (
    <div className="space-y-8">
      <div className="flex justify-between items-end">
        <div>
          <h2 className="text-3xl font-bold text-slate-900">Latest from Amassoma</h2>
          <p className="text-slate-600 mt-1">Updates on community projects, events, and education.</p>
        </div>
        <button className="text-blue-600 font-semibold hover:underline">View All News</button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        {MOCK_NEWS.map((item) => (
          <div key={item.id} className="bg-white rounded-2xl overflow-hidden shadow-sm border border-slate-100 hover:shadow-md transition-shadow group">
            <div className="h-48 overflow-hidden">
              <img 
                src={item.imageUrl} 
                alt={item.title} 
                className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              />
            </div>
            <div className="p-6">
              <div className="flex items-center gap-2 mb-3">
                <span className="bg-blue-100 text-blue-700 text-xs font-bold px-2 py-1 rounded uppercase tracking-wider">
                  {item.category}
                </span>
                <span className="text-slate-400 text-sm">• {item.date}</span>
              </div>
              <h3 className="text-xl font-bold mb-2 text-slate-900 group-hover:text-blue-600 transition-colors">
                {item.title}
              </h3>
              <p className="text-slate-600 line-clamp-2 mb-4">
                {item.summary}
              </p>
              <div className="flex items-center justify-between mt-auto">
                <span className="text-sm font-medium text-slate-700">By {item.author}</span>
                <button className="text-blue-600 text-sm font-bold flex items-center gap-1">
                  Read More
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default NewsBlog;
