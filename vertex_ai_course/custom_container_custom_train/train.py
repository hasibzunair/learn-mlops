#!/usr/bin/env python
# coding: utf-8

# ### Training notebook for IRIS dataset

# In[1]:


import pandas as pd


# In[3]:


data = pd.read_csv("gs://my_custom_container_training/IRIS.csv")


# ### Data preprocessing

# In[7]:


# Input data, output data
from sklearn.model_selection import train_test_split
array = data.values
X = array[:,0:4]
y = array[:,4]
# Split the data to train and test dataset.
X_train, X_test, y_train, y_test = train_test_split(X, y,test_size=0.20, random_state=1)


# In[8]:


X_train.shape, y_train.shape


# ### Train

# In[9]:


from sklearn.svm import SVC
svn = SVC()
svn.fit(X_train, y_train)


# ### Test

# In[10]:


predictions = svn.predict(X_test)
# Calculate the accuracy 
from sklearn.metrics import accuracy_score 
accuracy_score(y_test, predictions)


# ### Save model

# In[11]:


import pickle
import logging
with open('model.pkl', 'wb') as model_file:
    pickle.dump(svn, model_file)


# ### Export model to GCS

# In[12]:


from google.cloud import storage
storage_path = "gs://my_custom_container_training/model.pkl"
blob = storage.blob.Blob.from_string(storage_path, client=storage.Client())
blob.upload_from_filename('model.pkl')
logging.info("model exported to : {}".format(storage_path))


# In[ ]:




