Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383F1BD4EB
	for <netfs@lists.linux.dev>; Thu, 10 Oct 2024 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559019; cv=none; b=vATckTb1HWaYOwX4NlkoF+1eHlTyXQo0vza1/iAMGztQr3ECWMr0pYCMh0xmDuVDD1xpctkWL8lLY6luvqEFBDyEOR/7LK5IqfWMBiYk6f4RGVtRfDRaUGty5I42rFEMWUiJkcZ0xXGwpxlo2nQB5BDW3HQn9wbZOFVLz6+x6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559019; c=relaxed/simple;
	bh=5NQRMk+e+srTIrFvRoWCp1jv+sUYAoVk2R8Xc1utZeY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gAfK7dCQ6i+rvEk7loxyFwyuGaBcWo/m5V1XlN+W9HwZ8er+7ce2ewEMKEVkGkV7BHv8iArAKA0Y4Az1YUbUD+FUvGjfYw+xAaoPfVRvnL11sm4TGMsIPBeeEPHQtBj8bYH3x4a/Exj1p0aHn/ZCA4qWSuFje4ANl69jyYlXBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcSeqJwA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcSeqJwA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5tSqNiLfQZoZqE5JUG8Byob3AcTf76CH9na62lK+mk=;
	b=RcSeqJwAu4tPaAK+y8BH2taMox1V0+9ubYmMlz6Qp5EEWwTOhMYTlZpUyKAj5wgPlvNdJr
	NGdUDMAn8SW5GqQjESQBzqlA27dyXchKZlxizerNtq4LKbhv9pSEhSKJZ3y4YKS7usuhhb
	k9aB07tEF6pQlVXSK8l0hj89Nhp6P2Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-N_qhrj8XOVeNEqrYwZJs2A-1; Thu,
 10 Oct 2024 07:16:52 -0400
X-MC-Unique: N_qhrj8XOVeNEqrYwZJs2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1221D1955EE6;
	Thu, 10 Oct 2024 11:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37228300018D;
	Thu, 10 Oct 2024 11:16:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-5-wozizhi@huawei.com>
References: <20240821024301.1058918-5-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 4/8] cachefiles: Clear invalid cache data in advance
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303669.1728559002.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:16:42 +0100
Message-ID: <303670.1728559002@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the current on-demand loading scenario, when umount is called, the
> cachefiles_commit_tmpfile() is invoked. When checking the inode
> corresponding to object->file is inconsistent with the dentry,
> cachefiles_unlink() is called to perform cleanup to prevent invalid data
> from occupying space.
> 
> The above operation does not apply to the first mount, because the cache
> dentry generated by the first mount must be negative. Moreover, there is no
> need to clear it during the first umount because this part of the data may
> be reusable in the future. But the problem is that, the clean operation can
> currently only be called through cachefiles_withdraw_cookie(), in other
> words the redundant data does not cleaned until the second umount. This
> means that during the second mount, the old cache data generated from the
> first mount still occupies space. So if the user does not manually clean up
> the previous cache before the next mount, it may return insufficient space
> during the second mount phase.
> 
> This patch adds an additional cleanup process in the cachefiles_open_file()
> function. When the auxdata check fails, the remaining old cache data is no
> longer needed, the file and dentry corresponding to the object are also
> put. As there is no need to clear it until umount, we can directly clear it
> during the mount process.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Okay, I think this is reasonable as it's done from a worker thread.  I wonder
if instead, though, cachefiles_create_file() should be called and then linked
over the top:

	https://lore.kernel.org/all/cover.1580251857.git.osandov@fb.com/

though AT_LINK_REPLACE seemed to get stuck.

Note that we can't just truncate the file to nothing instead because I/O might
be in progress on it.

David

