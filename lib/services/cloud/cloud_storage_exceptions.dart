class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteException extends CloudStorageException {}

class CouldNotGetAllNotesException extends CloudStorageException {}

class CouldNotUpdateNoteException extends CloudStorageException {}

class CouldNotDeleteNoteException extends CloudStorageException {}

class CouldNotCreateJobException extends CloudStorageException {}

class CouldNotGetAllJobsException extends CloudStorageException {}

class CouldNotUpdateJobException extends CloudStorageException {}

class CouldNotDeleteJobException extends CloudStorageException {}

class CouldNotCreateSessionException extends CloudStorageException {}

class CouldNotGetAllSessionsException extends CloudStorageException {}

class CouldNotUpdateSessionException extends CloudStorageException {}

class CouldNotDeleteSessionException extends CloudStorageException {}

class CouldNotCreateStackException extends CloudStorageException {}

class CouldNotGetAllStackException extends CloudStorageException {}

class CouldNotUpdateStackException extends CloudStorageException {}

class CouldNotDeleteStackException extends CloudStorageException {}

class CouldNotCreateSetException extends CloudStorageException {}

class CouldNotGetAllSetException extends CloudStorageException {}

class CouldNotUpdateSetException extends CloudStorageException {}

class CouldNotDeleteSetException extends CloudStorageException {}