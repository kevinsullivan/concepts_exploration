package edu.uva.cs.concepts.lambda.concrete;

import edu.uva.cs.concepts.Actions;
import edu.uva.cs.concepts.SerDer;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.actions.S3Actions;
import edu.uva.cs.concepts.lambda.LambdaActionFactory;

// appropriat factory creatd ar runtime
public abstract class LambdaCollectionActionFactory<T> extends LambdaActionFactory<Collection<T>> { }
