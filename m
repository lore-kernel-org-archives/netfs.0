Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674415E5BB
	for <netfs@lists.linux.dev>; Tue, 14 Apr 2026 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153745; cv=none; b=PV8JXDRifPe/Y/1JFej0P7UxX2JwXgvAq/hPPBYpFcKHff+o8MTCRlwAv35HywdChJ3KCcElEHEr6hOWVbquv8/o9ktNXocF26yGK1fTMD/msT8lSiamHF3NRXNFTNLQMzNRr7xxEhcxHZ6xYI3iZ++Bnt5JGXQNym7/9U+m0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153745; c=relaxed/simple;
	bh=JJFZCN3rB5RE2spFMluEVpX8vCNqZ50mkbSkFhz2niU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=ThZrYcXvHLzb1rRonk0ZVrTu9stb1rRQ3OzBrCon5gckpPxx5S6ycUXNKFWmGKNO1gj0y+rWX9ENmRmruUsFwEce+byqMxtKiGz3pty2E4taYeHZdZ63RCbc8ZuKGYu93Hv9G4755e/eDABqUaH/zmpr7jYbcYShXG/0tucRhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRL6ZlZz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRL6ZlZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJFZCN3rB5RE2spFMluEVpX8vCNqZ50mkbSkFhz2niU=;
	b=RRL6ZlZze/Wa51dyveCJDFv6ilEgYsfsTjwbdYSoyTcq1CYr0ywi9lJ+kbkglH+VbmWO0E
	f+J6G4GHisvtFEpmwHMH4kyxWkaVW8gFy9CpUMBQwyUpULBilR5DH7NT0BmMkPABhTGNOO
	SaON2ULMrllEBrJXsesNIOsKNUJ5AMc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-e-mrVy0ROXuXltmJMHSNPA-1; Tue,
 14 Apr 2026 04:02:16 -0400
X-MC-Unique: e-mrVy0ROXuXltmJMHSNPA-1
X-Mimecast-MFC-AGG-ID: e-mrVy0ROXuXltmJMHSNPA_1776153733
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22DE118011FF;
	Tue, 14 Apr 2026 08:02:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.34.160])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 227F518002A6;
	Tue, 14 Apr 2026 08:02:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9639cd12-5e9d-4eb4-9d9c-f5047ccad7b7@samba.org>
References: <9639cd12-5e9d-4eb4-9d9c-f5047ccad7b7@samba.org> <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org> <20260326104544.509518-1-dhowells@redhat.com> <1180465.1774867781@warthog.procyon.org.uk>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] netfs: Keep track of folios in a segmented bio_vec[] chain
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 09:02:00 +0100
Message-ID: <3755493.1776153720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: uD4IOQeM29gnF72C2f_M9_i8HIZwYy6ip2rGOriAsNU_1776153733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3755492.1776153720.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Stefan Metzmacher <metze@samba.org> wrote:

> Any idea on how to resolve the actual conflict?

I didn't manage to beat the bugs out in time (turned out several were
preexisting).

However, if you look here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?=
h=3Dcifs-next

I've stacked my patchset on top of yours and modified smbdirect_connection.=
c
appropriately.

David

