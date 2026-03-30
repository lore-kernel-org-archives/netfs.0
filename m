Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4C3C0634
	for <netfs@lists.linux.dev>; Mon, 30 Mar 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867806; cv=none; b=SB+Xv+OtO/NBrV1lyutk0ddPkqfa5/GsRbZmw6rUbLgboR21vcRKmPCevW+y9xajOedC+fcnXPDdkPWXiF0AGVGO4DXwNXNoJ447/Aebs83qBUFbRP8q+y5M0rRhNqJb67Y0E9tAN+cGItxt6o/4Ej4yEfdBvCmfh0Hq644KDcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867806; c=relaxed/simple;
	bh=rkX3ZpoDYjVfKThIe6nRJg+WV4QDMgWCxcdEimVscKw=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:From:Date:
	 Message-ID:Content-Type; b=O1XHizANpXRkE77HloRQ7qKLw6/FVat9TOr+3jZ0z9GwijAeBVBYvoBukF3bntXaSKoZL4DFyFGjTgssBC147uIEBdINlrRLIF0eNQeujle1Sgrc8C7o4MOG5kOSMlIgRGG5DuRPUKJmT46QRpgW21+af3fQ0Petvnhjzl1r3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0n734+T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0n734+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774867804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WG/SeRSfzsyNWeLhZKLjrg2/KPXx46Pf/FiBPy0PmY=;
	b=P0n734+TJcw6deuQFQwCd1i5cE985h1zhEMPRyqL4gYZMmqIJqtR8aXzR+pe8+VQZ6KrGG
	MwGX6XkRqaJ0gAYRSMZzM9TDyCHZ+DCMh+ie+O1Riy65rl1qoQErLeofLlBzjX49+rx53G
	VWZ4IYUARgz7+pYQ2LoO/b1QGT4se98=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-JLNIgM7fPXu4cdrMLHIQ5w-1; Mon,
 30 Mar 2026 06:49:58 -0400
X-MC-Unique: JLNIgM7fPXu4cdrMLHIQ5w-1
X-Mimecast-MFC-AGG-ID: JLNIgM7fPXu4cdrMLHIQ5w_1774867795
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30281944F11;
	Mon, 30 Mar 2026 10:49:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 543211955D84;
	Mon, 30 Mar 2026 10:49:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org>
References: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org> <20260326104544.509518-1-dhowells@redhat.com>
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
From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Mar 2026 11:49:41 +0100
Message-ID: <1180465.1774867781@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: LchIrRH7g7qneNzVSeo7M35RVqc8lBi0fm2T862ezLA_1774867795
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1005366.1774861048.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Stefan Metzmacher <metze@samba.org> wrote:

> Another possible way would be to skip this for now
> cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_r=
dma()
> and I rebase my changes on top of Davids patches assuming they
> will be stable commits (at least up to
> cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma())

I could certainly split my removal patch.  I want to remove FOLIOQ support,
but I can leave KVEC and/or BVEC if they're still needed.

David

