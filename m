Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3A194C8A
	for <netfs@lists.linux.dev>; Tue, 30 Apr 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486207; cv=none; b=oC6Z2ANKhXjFW2Fit+bsFB/CkHZvl7ZAQv3nViGgZvC78n3b6c04k7IYfB2x3UU0fLfP1D3iEV7SZOte2eMs+T1ykntBR2tmu2wvoYDZG3j9wSZGYKaZ8v+sAoLAbA4a6zijcxgW3/LRQugxEwtDdW+hReD8k2R5oK/JExpx9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486207; c=relaxed/simple;
	bh=wK/mkDwnXcFoN6Kk8jF+KKpRm6Qw7OPNAXKO72bPoec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7ypVK98eokrS7PQW5LdhlVYdUdF1s6BUEtWVK0wvatekVk+FGaOIC9Ky19aAFKzMrglVh5kRFPED9804rTLZllTuTgRZMqHcry1q/EwAQGuWZBomT0A2BmXbKxc4Ht8xYwe5AATd1qC6gF4xpiY0xoxacwyUotXg3uSmT9iE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idY70WuG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idY70WuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rx29y3wht5apPqGuZYnZRRxzhBh5LDn/UDQzoEUVDzQ=;
	b=idY70WuGDLfOWwrGWh0JOFNJwfK9rbN4gP1ft2pyYULy/h3eLqvFkqZZ1Ead9KBmZV9fEY
	t7QUzu9odMZcxjJbyVSgc0JAN5TsggG1061tTO5OZnmQmmL+RnQW1VuRjHLlrwmD/wIXjE
	SvQ+YveCv6tSfSGL3xc4ds2hv/T+068=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-0ZBkhGgIPE2HLkFmUPugHQ-1; Tue,
 30 Apr 2024 10:10:01 -0400
X-MC-Unique: 0ZBkhGgIPE2HLkFmUPugHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D3851C03152;
	Tue, 30 Apr 2024 14:10:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C7831C0666B;
	Tue, 30 Apr 2024 14:09:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v7 10/16] cifs: Make add_credits_and_wake_if() clear deducted credits
Date: Tue, 30 Apr 2024 15:09:22 +0100
Message-ID: <20240430140930.262762-11-dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Make add_credits_and_wake_if() clear the amount of credits in the
cifs_credits struct after it has returned them to the overall counter.
This allows add_credits_and_wake_if() to be called multiple times during
the error handling and cleanup without accidentally returning the credits
again and again.

Note that the wake_up() in add_credits_and_wake_if() may also be
superfluous as ->add_credits() also does a wake on the request_q.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 29c9ee2dd304..611f59c6d2c0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -881,11 +881,12 @@ add_credits(struct TCP_Server_Info *server, const struct cifs_credits *credits,
 
 static inline void
 add_credits_and_wake_if(struct TCP_Server_Info *server,
-			const struct cifs_credits *credits, const int optype)
+			struct cifs_credits *credits, const int optype)
 {
 	if (credits->value) {
 		server->ops->add_credits(server, credits, optype);
 		wake_up(&server->request_q);
+		credits->value = 0;
 	}
 }
 

