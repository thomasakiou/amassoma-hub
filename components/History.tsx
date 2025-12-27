
import React, { useState } from 'react';
import { getHistoryInsight } from '../services/geminiService';
import { ICONS } from '../constants';

const History: React.FC = () => {
  const [query, setQuery] = useState('');
  const [insight, setInsight] = useState('');
  const [loading, setLoading] = useState(false);

  const topics = [
    "Origin of Amassoma name",
    "Niger Delta University founding",
    "Amassoma Boat Regatta",
    "Traditional Marriage in Izon culture",
    "Fishing traditions in Southern Ijaw"
  ];

  const fetchInsight = async (topic: string) => {
    setLoading(true);
    setQuery(topic);
    const result = await getHistoryInsight(topic);
    setInsight(result || 'Information unavailable.');
    setLoading(false);
  };

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <div className="lg:col-span-2 space-y-6">
        <div className="bg-white p-8 rounded-2xl shadow-sm border border-slate-200">
          <h2 className="text-3xl font-bold mb-4">Our Heritage</h2>
          <div className="prose prose-slate max-w-none text-slate-700 space-y-4">
            <p className="text-lg leading-relaxed">
              Amassoma is a historic town nestled in the heart of the Southern Ijaw Local Government Area of Bayelsa State, Nigeria. 
              Known as the seat of the <strong className="text-blue-600">Niger Delta University (NDU)</strong>, it serves as an educational and cultural hub for the Izon people.
            </p>
            <p>
              The history of Amassoma is deeply tied to the Nun River and the vast network of creeks that define the landscape of the Niger Delta. 
              Our people are resilient, known for their bravery, hospitality, and rich oral traditions passed down through generations.
            </p>
            <div className="h-64 rounded-xl overflow-hidden my-6">
              <img src="https://picsum.photos/seed/river/800/400" className="w-full h-full object-cover" alt="Niger Delta Landscape" />
            </div>
          </div>
        </div>

        {insight && (
          <div className="bg-blue-50 p-8 rounded-2xl border border-blue-100 animate-in fade-in slide-in-from-bottom-4 duration-500">
            <h3 className="text-xl font-bold text-blue-900 mb-4 flex items-center gap-2">
              <ICONS.History />
              Insights on: {query}
            </h3>
            <div className="prose prose-blue max-w-none text-slate-700 whitespace-pre-wrap">
              {insight}
            </div>
          </div>
        )}
      </div>

      <div className="space-y-6">
        <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
          <h3 className="text-xl font-bold mb-4">Discover Topics</h3>
          <p className="text-sm text-slate-500 mb-4">Click a topic to learn more about our history through AI insights.</p>
          <div className="flex flex-wrap gap-2">
            {topics.map((topic) => (
              <button
                key={topic}
                onClick={() => fetchInsight(topic)}
                className="bg-slate-100 hover:bg-blue-100 hover:text-blue-700 px-4 py-2 rounded-full text-sm font-medium transition-colors text-slate-700"
              >
                {topic}
              </button>
            ))}
          </div>
        </div>

        <div className="bg-gradient-to-br from-blue-600 to-indigo-700 p-6 rounded-2xl text-white shadow-lg">
          <h3 className="text-xl font-bold mb-2">Did You Know?</h3>
          <p className="text-blue-100 text-sm leading-relaxed">
            Amassoma is the ancestral home to some of the most prominent families in the Izon ethnic group. It is also home to Wilberforce Island, where the premier state university of Bayelsa sits.
          </p>
        </div>
      </div>
    </div>
  );
};

export default History;
